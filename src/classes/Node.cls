public class Node {
	
	public Integer value { get; set; }
	public Node next { get; set; }

	public static void printList (Node node) {
		while (node != NULL) {
			System.debug(node.value);
			node = node.next;
		}
	}

} // end Node class