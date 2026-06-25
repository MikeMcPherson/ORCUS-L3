DrawInner = false;
DrawOuter = false;

LaserKerf=0.175;

offset(delta=LaserKerf/2) {
    if(DrawInner) {
        projection() {
            import("BulkheadNoseconeInner.stl");
        }
    }
    if(DrawOuter) {
        projection() {
            import("BulkheadNoseconeOuter.stl");
        }
    }
}
