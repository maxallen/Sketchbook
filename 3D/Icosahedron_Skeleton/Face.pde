class Edge {
  PVector v1, v2;
  public Edge(PVector a, PVector b){
    v1 = a.get();
    v2 = b.get();
  }
  
  public boolean sameEdgeAs(PVector a, PVector b){
    return this.sameEdgeAs(new Edge(a,b));
  }
  
  public boolean sameEdgeAs(Edge e){
    return (v1.equals(e.v1) && v2.equals(e.v2)) || (v1.equals(e.v2) && v2.equals(e.v1));
  }
}
