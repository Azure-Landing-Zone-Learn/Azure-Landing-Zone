1. TCP (Transmission Control Protocol)
TCP is a connection-oriented protocol, meaning it establishes a connection between the sender and receiver before transmitting data. It ensures that data packets are sent, received, and acknowledged in the correct order. TCP guarantees reliable delivery of data.

Key Features:
Connection-oriented: Requires a handshake (three-way handshake) to establish a connection before data is sent.
Reliable: Ensures all data reaches the destination correctly, with retransmission if packets are lost.
Ordered: Data packets arrive in the same order they were sent.
Error checking: Includes mechanisms for error detection and correction.
Slower than UDP due to overhead (establishing connections, error checking, and acknowledgment).
Use Cases:
When reliability is critical:
Web browsing (HTTP/HTTPS) – Ensures web pages load correctly.
File transfers (FTP, SFTP) – Ensures files are transmitted without corruption.
Email (SMTP, IMAP, POP3) – Ensures emails are delivered completely.
Remote access (SSH, Telnet) – Guarantees accurate and secure communication.
2. UDP (User Datagram Protocol)
UDP is a connectionless protocol, meaning it does not establish a formal connection before sending data. It simply sends data without waiting for an acknowledgment, making it much faster but less reliable than TCP.

Key Features:
Connectionless: No handshake; data is sent without setting up a connection.
Unreliable: No guarantee that the data will arrive at the destination, or in the correct order.
No retransmission: Lost packets are not resent.
Faster than TCP because it has less overhead.
Low latency: Preferred when speed is more important than reliability.
Use Cases:
When speed is critical, and some data loss is acceptable:
Streaming (video/audio) – In real-time applications (e.g., YouTube, VoIP), small data losses are tolerable, and speed is prioritized.
Online gaming – Fast response times are needed, and losing a few packets won't significantly impact the user experience.
DNS queries – DNS (like the rule example you shared) uses UDP to quickly resolve domain names to IP addresses.
3. ICMP (Internet Control Message Protocol)
ICMP is neither connection-oriented like TCP nor connectionless like UDP. Instead, it’s used for diagnostic and control purposes in network communication. It helps report errors and manage connections but is not used to transfer data between applications.

Key Features:
Used for error messages and operational information.
Commonly known for ping and traceroute utilities.
It’s connectionless and does not establish a connection or guarantee delivery of packets.
Use Cases:
Network diagnostics:
Ping – Check if a host is reachable.
Traceroute – Determine the route packets take to reach a host.
Network error reporting – Routers use ICMP to report issues like unreachable destinations or network congestion.
When to Use What:
TCP: Use when reliability and data integrity are important. This is essential for applications where all data needs to arrive without loss, in the correct order.

Examples: Web browsing, email, file transfers, remote desktop connections.
UDP: Use when speed and low latency are important, and some packet loss is acceptable.

Examples: Video/audio streaming, online gaming, DNS queries, VoIP (like Zoom, Skype).
ICMP: Use for network diagnostics and control, like testing connectivity with ping or tracing network routes with traceroute.

Each protocol has its strengths and is suited for different types of network communication based on the needs for speed, reliability, and the nature of the data being transmitted.