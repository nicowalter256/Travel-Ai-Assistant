import 'package:flutter/material.dart';
import 'data/api/chat_api.dart';
import 'data/repositories/chat_repository_impl.dart';
import 'domain/usecases/send_chat_message.dart';
import 'domain/models/chat_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;
  late final SendChatMessage _sendChatMessage;
  late final ChatRepositoryImpl _chatRepository;
  String? _userName;
  bool _isAskingName = true;
  bool _showDestinations = false;
  bool _showDatePicker = false;
  bool _showBudgetSelector = false;
  bool _showTravelerTypeSelector = false;
  DateTimeRange? _selectedDateRange;

  final List<Destination> _destinations = [
    Destination(
      name: 'Beach Getaways',
      icon: Icons.beach_access,
      description: 'Relaxing beach vacations with sun, sand, and sea',
    ),
    Destination(
      name: 'City Breaks',
      icon: Icons.location_city,
      description: 'Urban adventures in vibrant cities',
    ),
    Destination(
      name: 'Cultural Tours',
      icon: Icons.temple_buddhist,
      description: 'Explore rich history and traditions',
    ),
    Destination(
      name: 'Nature & Wildlife',
      icon: Icons.landscape,
      description: 'Adventure in natural wonders and wildlife',
    ),
    Destination(
      name: 'Food & Wine',
      icon: Icons.restaurant,
      description: 'Culinary journeys and wine tasting',
    ),
    Destination(
      name: 'Adventure Sports',
      icon: Icons.sports_handball,
      description: 'Thrilling outdoor activities and sports',
    ),
    Destination(
      name: 'Wellness Retreats',
      icon: Icons.spa,
      description: 'Relaxation and wellness focused trips',
    ),
    Destination(
      name: 'Road Trips',
      icon: Icons.directions_car,
      description: 'Scenic drives and exploration',
    ),
  ];

  final List<BudgetRange> _budgetRanges = [
    BudgetRange(
      range: 'Under \$1,000',
      min: 0,
      max: 1000,
      icon: Icons.attach_money,
    ),
    BudgetRange(
      range: '\$1,000 - \$2,000',
      min: 1000,
      max: 2000,
      icon: Icons.attach_money,
    ),
    BudgetRange(
      range: '\$2,000 - \$5,000',
      min: 2000,
      max: 5000,
      icon: Icons.attach_money,
    ),
    BudgetRange(
      range: '\$5,000+',
      min: 5000,
      max: double.infinity,
      icon: Icons.attach_money,
    ),
  ];

  final List<TravelerType> _travelerTypes = [
    TravelerType(
      type: 'Solo',
      icon: Icons.person,
      description: 'Traveling alone',
    ),
    TravelerType(
      type: 'Couple',
      icon: Icons.favorite,
      description: 'Two people traveling together',
    ),
    TravelerType(
      type: 'Family',
      icon: Icons.family_restroom,
      description: 'Traveling with family members',
    ),
    TravelerType(
      type: 'Friends',
      icon: Icons.groups,
      description: 'Traveling with friends',
    ),
    TravelerType(
      type: 'Group',
      icon: Icons.group,
      description: 'Large group travel',
    ),
  ];

  @override
  void initState() {
    super.initState();
    final chatApi = ChatApi();
    _chatRepository = ChatRepositoryImpl(chatApi);
    _sendChatMessage = SendChatMessage(_chatRepository);

    // Load chat history
    _loadChatHistory();

    // Add initial greeting message if no history exists
    if (_messages.isEmpty) {
      _addMessage(
        "Hello! I'm your AI travel assistant. What's your name?",
        isUser: false,
      );
    }
  }

  Future<void> _loadChatHistory() async {
    final history = await _chatRepository.getChatHistory();
    if (history.isNotEmpty) {
      setState(() {
        _messages.addAll(history);
        // Set the user's name if it exists in the history
        final nameMessage = history.firstWhere(
          (msg) =>
              msg.isUser &&
              !msg.text.contains('traveling') &&
              !msg.text.contains('budget'),
          orElse: () => ChatMessage(
            id: '',
            text: '',
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
        if (nameMessage.text.isNotEmpty) {
          _userName = nameMessage.text;
          _isAskingName = false;
        }
      });
    }
  }

  Future<void> _addMessage(String text, {required bool isUser}) async {
    final message = ChatMessage(
      id: _chatRepository.generateMessageId(),
      text: text,
      isUser: isUser,
      timestamp: DateTime.now(),
      sessionId: _chatRepository.sessionId,
    );

    setState(() {
      _messages.add(message);
    });

    // Save message to Supabase
    await _chatRepository.saveMessage(message);
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      initialDateRange: _selectedDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Theme.of(context).colorScheme.primary,
                ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
        _showDatePicker = false;
      });

      final startDate =
          "${picked.start.day}/${picked.start.month}/${picked.start.year}";
      final endDate =
          "${picked.end.day}/${picked.end.month}/${picked.end.year}";
      _messageController.text = "I want to travel from $startDate to $endDate";

      // First add the user's date selection
      setState(() {
        _messages.add(ChatMessage(
          id: _chatRepository.generateMessageId(),
          text: _messageController.text,
          isUser: true,
          timestamp: DateTime.now(),
          sessionId: _chatRepository.sessionId,
        ));
      });

      // Then get AI response and show budget selector
      try {
        final response = await _sendChatMessage(_messageController.text);
        if (mounted) {
          setState(() {
            _messages.add(ChatMessage(
              id: _chatRepository.generateMessageId(),
              text: response,
              isUser: false,
              timestamp: DateTime.now(),
              sessionId: _chatRepository.sessionId,
            ));
            _messages.add(
              ChatMessage(
                id: _chatRepository.generateMessageId(),
                text: "Great! Now, what's your total budget for the trip?",
                isUser: false,
                timestamp: DateTime.now(),
                sessionId: _chatRepository.sessionId,
              ),
            );
            _showBudgetSelector = true;
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _messages.add(
              ChatMessage(
                id: _chatRepository.generateMessageId(),
                text:
                    "I apologize, but I'm having trouble connecting right now. Please try again later.",
                isUser: false,
                timestamp: DateTime.now(),
                sessionId: _chatRepository.sessionId,
              ),
            );
          });
        }
      }
    }
  }

  void _handleDestinationSelection(String destination) {
    _messageController.text = "I'm interested in $destination";
    _handleSubmitted(_messageController.text);
    setState(() {
      _showDestinations = false;
      _showDatePicker = true;
    });
  }

  void _handleBudgetSelection(BudgetRange budget) {
    _messageController.text = "My budget is ${budget.range}";
    _handleSubmitted(_messageController.text);
    setState(() {
      _showBudgetSelector = false;
    });
  }

  void _handleTravelerTypeSelection(TravelerType travelerType) {
    _messageController.text =
        "I'm traveling as a ${travelerType.type.toLowerCase()}";
    _handleSubmitted(_messageController.text);
    setState(() {
      _showTravelerTypeSelector = false;
    });
  }

  Future<void> _handleSubmitted(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = text.trim();
    _messageController.clear();

    setState(() {
      _messages.add(ChatMessage(
        id: _chatRepository.generateMessageId(),
        text: userMessage,
        isUser: true,
        timestamp: DateTime.now(),
        sessionId: _chatRepository.sessionId,
      ));
      _isTyping = true;
    });

    try {
      if (_isAskingName) {
        // Handle name response
        setState(() {
          _userName = userMessage;
          _isAskingName = false;
          _messages.add(
            ChatMessage(
              id: _chatRepository.generateMessageId(),
              text:
                  "Nice to meet you, $_userName! Do you have a destination in mind, or would you like me to suggest something?",
              isUser: false,
              timestamp: DateTime.now(),
              sessionId: _chatRepository.sessionId,
            ),
          );
          _showDestinations = true;
          _isTyping = false;
        });
      } else if (_showDatePicker) {
        // Handle date selection
        final response = await _sendChatMessage(userMessage);
        if (mounted) {
          setState(() {
            _messages.add(ChatMessage(
              id: _chatRepository.generateMessageId(),
              text: response,
              isUser: false,
              timestamp: DateTime.now(),
              sessionId: _chatRepository.sessionId,
            ));
            _messages.add(
              ChatMessage(
                id: _chatRepository.generateMessageId(),
                text: "Great! Now, what's your total budget for the trip?",
                isUser: false,
                timestamp: DateTime.now(),
                sessionId: _chatRepository.sessionId,
              ),
            );
            _showBudgetSelector = true;
            _isTyping = false;
          });
        }
      } else if (_showBudgetSelector) {
        // Handle budget selection
        setState(() {
          _messages.add(
            ChatMessage(
              id: _chatRepository.generateMessageId(),
              text: "Perfect! Now, will you be traveling alone or with others?",
              isUser: false,
              timestamp: DateTime.now(),
              sessionId: _chatRepository.sessionId,
            ),
          );
          _showTravelerTypeSelector = true;
          _isTyping = false;
        });
      } else if (_showTravelerTypeSelector) {
        // Get the selected budget range
        final selectedBudget = _budgetRanges.firstWhere(
          (budget) => _messages
              .any((msg) => msg.isUser && msg.text.contains(budget.range)),
          orElse: () => _budgetRanges.first,
        );

        // Create a prompt for the AI with all the collected information
        final prompt =
            "I'm planning a trip with a budget of ${selectedBudget.range} and I'm traveling as a ${userMessage.toLowerCase()}. "
            "Can you suggest some specific destinations and activities that would be suitable for my budget and travel style? "
            "Please include estimated costs and any special considerations for my travel type.";

        final response = await _sendChatMessage(prompt);
        if (mounted) {
          setState(() {
            _messages.add(ChatMessage(
              id: _chatRepository.generateMessageId(),
              text: response,
              isUser: false,
              timestamp: DateTime.now(),
              sessionId: _chatRepository.sessionId,
            ));
            _messages.add(
              ChatMessage(
                id: _chatRepository.generateMessageId(),
                text:
                    "Would you like me to provide more specific details about any of these suggestions?",
                isUser: false,
                timestamp: DateTime.now(),
                sessionId: _chatRepository.sessionId,
              ),
            );
            _isTyping = false;
          });
        }
      } else {
        // Handle regular chat messages
        final response = await _sendChatMessage(userMessage);
        if (mounted) {
          setState(() {
            _messages.add(ChatMessage(
              id: _chatRepository.generateMessageId(),
              text: response,
              isUser: false,
              timestamp: DateTime.now(),
              sessionId: _chatRepository.sessionId,
            ));
            _isTyping = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _messages.add(
            ChatMessage(
              id: _chatRepository.generateMessageId(),
              text:
                  "I apologize, but I'm having trouble connecting right now. Please try again later.",
              isUser: false,
              timestamp: DateTime.now(),
              sessionId: _chatRepository.sessionId,
            ),
          );
          _isTyping = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _userName != null ? 'Chat with $_userName' : 'AI Travel Assistant'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == 0 && _isTyping) {
                  return const _TypingIndicator();
                }
                final message = _messages[
                    _messages.length - 1 - (_isTyping ? index - 1 : index)];
                return Column(
                  children: [
                    _ChatBubble(message: message),
                    if (_showDestinations &&
                        message == _messages.last &&
                        !message.isUser)
                      _buildDestinationGrid(),
                    if (_showDatePicker &&
                        message == _messages.last &&
                        !message.isUser)
                      _buildDatePickerButton(),
                    if (_showBudgetSelector &&
                        message == _messages.last &&
                        !message.isUser)
                      _buildBudgetSelector(),
                    if (_showTravelerTypeSelector &&
                        message == _messages.last &&
                        !message.isUser)
                      _buildTravelerTypeSelector(),
                  ],
                );
              },
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildMessageComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationGrid() {
    // Get the selected budget range
    final selectedBudget = _budgetRanges.firstWhere(
      (budget) =>
          _messages.any((msg) => msg.isUser && msg.text.contains(budget.range)),
      orElse: () => _budgetRanges.first,
    );

    // Get the selected traveler type
    final selectedTravelerType = _travelerTypes.firstWhere(
      (type) => _messages.any(
          (msg) => msg.isUser && msg.text.contains(type.type.toLowerCase())),
      orElse: () => _travelerTypes.first,
    );

    // Filter destinations based on budget and traveler type
    final filteredDestinations = _destinations.where((destination) {
      // Add your filtering logic here based on budget and traveler type
      // For now, we'll show all destinations
      return true;
    }).toList();

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Suggested destinations for ${selectedTravelerType.type} travelers with a budget of ${selectedBudget.range}:',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: filteredDestinations.map((destination) {
              return Card(
                elevation: 2,
                child: InkWell(
                  onTap: () => _handleDestinationSelection(destination.name),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    width: 150,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          destination.icon,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          destination.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          destination.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePickerButton() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: _selectDateRange,
        icon: const Icon(Icons.calendar_today),
        label: Text(_selectedDateRange == null
            ? 'Select Travel Dates'
            : '${_selectedDateRange!.start.day}/${_selectedDateRange!.start.month}/${_selectedDateRange!.start.year} - ${_selectedDateRange!.end.day}/${_selectedDateRange!.end.month}/${_selectedDateRange!.end.year}'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildBudgetSelector() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select your budget range:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _budgetRanges.map((budget) {
              return Card(
                elevation: 2,
                child: InkWell(
                  onTap: () => _handleBudgetSelection(budget),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    width: 150,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          budget.icon,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          budget.range,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTravelerTypeSelector() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select your travel type:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _travelerTypes.map((type) {
              return Card(
                elevation: 2,
                child: InkWell(
                  onTap: () => _handleTravelerTypeSelection(type),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    width: 150,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          type.icon,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          type.type,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          type.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: _isAskingName
                    ? 'Enter your name...'
                    : 'Ask me anything about travel...',
                border: InputBorder.none,
              ),
              onSubmitted: _handleSubmitted,
              enabled: !_isTyping,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _isTyping
                ? null
                : () => _handleSubmitted(_messageController.text),
          ),
        ],
      ),
    );
  }
}

class Destination {
  final String name;
  final IconData icon;
  final String description;

  Destination({
    required this.name,
    required this.icon,
    required this.description,
  });
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) _buildAvatar(),
          const SizedBox(width: 8.0),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: message.isUser
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          if (message.isUser) _buildAvatar(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      backgroundColor: message.isUser ? Colors.blue : Colors.green,
      child: Icon(
        message.isUser ? Icons.person : Icons.travel_explore,
        color: Colors.white,
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.green,
            child: const Icon(
              Icons.travel_explore,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8.0),
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 8,
                  height: 8,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
                SizedBox(width: 8),
                Text('AI is typing...'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BudgetRange {
  final String range;
  final double min;
  final double max;
  final IconData icon;

  BudgetRange({
    required this.range,
    required this.min,
    required this.max,
    required this.icon,
  });
}

class TravelerType {
  final String type;
  final IconData icon;
  final String description;

  TravelerType({
    required this.type,
    required this.icon,
    required this.description,
  });
}
