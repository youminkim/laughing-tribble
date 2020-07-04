use <BezierScad/BezierScad.scad>;

$fn=20;

width = 1;
height = 1;
steps = 100;
centered = true;
connector = 0.75;

module leaf(pts, loc) {
    difference(){
        union(){
            translate(loc) 
                BezWall(pts, width, height, steps, centered);
            translate(pts[len(pts)-1])
                cylinder(1, 1);
        }

        translate(pts[len(pts)-1])
            scale([connector, connector, 1.1]) 
                cylinder(1, 1);
    }
            
}

module leafs(loc) {
    leaf (
        [[0,0], [-5,10], [10, 20], [5,40]], 
        loc
    );

    leaf (
        [[0,0], [-4,20], [10,5], [15,15]], 
        loc
    );

    leaf (
        [[0,0], [-5,10], [-2, 5], [-5,20]],
        loc
    );
}

module volt(loc) {
    translate(loc)
        cylinder(1, connector*0.97, true);
}

difference(){
    union(){
        leafs([0,0,0]);
        translate([0,0,0])
            cylinder(1, 1);
    }
    scale([connector, connector, 1.1]) cylinder(1, 1);
}

volt([9,0,0]);
volt([6,0,0]);
volt([3,0,0]);

