class GraphNode<int> {
  int value;
  List<GraphNode<int>> children;

  GraphNode(this.value) : children = [];

  void addChild(GraphNode<int> child) {
    children.add(child);
  }
}
