--- BEGIN YAML HEADER ---
layout: post
summary: Some technical details, tips and tricks for using Fusion360 to create laser cutter files
---- END YAML HEADER ----
{% block post_body %}

A collection of things I had to learn in using Fusion360 to design for a laser cutter. For context I've previously used LibreCAD for design and that's about it, better solutions may exist.

## Exporting ##

Fusion360 will export sketches as .dxf files BUT you probably want to prepare them carefully, otherwise you'll get a lot of cruft in them (e.g. construction lines). Here's my process:

1. Select the component that you want to export a cut file for
2. Create a new sketch 
3. Project the face(s) that you want to cut into that sketch (Either press 'P' or Sketch > Project/Include > Project)
4. Right click the sketch > 'Save as DXF'

This should create a sketch that only contains the shape you actually want to cut.

## Creating finger joints ##

Finger joints are the de-facto way to join laser cut components. They are also something you want to avoid making manually because it's fiddly and you'll often forget to add them somewhere. Using this technique means that you can make everything in-situ then derive the tabs rather than creating a flat net and hoping it assembles correctly.

Here's the system I found to make them in Fusion360:

1. Set up you parameters
    * Number of tabs (I'll use 'tabs' rather than 'fingers') per edge `n_tabs`
    * Thickness of your material `mat_thickness`
2. Create a sketch of one of your faces, ignoring the tabs, correctly sized.
3. Create an internal offset of `mat_thickness` from that face's edges. This will mark the inner edge of a tab.
4. Create a line, `mat_thickness` long, perpendicular to the edge you want to apply tabs to at one end of that edge.
5. Use the `Rectangular Pattern` tool to create `n_tabs + 1` copies of that line equally spaced along that edge (for external dimensions this is a spacing of `ext_length/n_tabs`)
6. Add any further tabs (I recommend using Mirror) you want then Extrude/Press-Pull that sketch. This is your tool body.
7. Create your second face in place (at 90 degrees, where it will be in the finished product) using external dimensions. This is your target body.
8. Select the Combine tool (Modify>Combine)
9. Set the target and tool bodies
10. Set the operation to 'Cut'
11. Make sure 'keep tools' is selected
11. Click ok. You have now applied the tabs to your target body.

A couple of general tips:

* Before you start choose whether you care about internal or external dimensions and stick to it.
* Build the general shape before you add any tabs
* Try to limit the number of faces you use as your tool faces and try to use a logical order. For example I use the base to cut all the outsides.

## Find Missing tabs ##

**NB** This won't find edges that are missing the tab on both faces, just places where you have two faces occupying the same space

1. Inspect > Interference
2. Select all the components 
    + If you set 'Include Coincident Faces' you'll get a view showing all places faces touch 
3. Click 'Compute'
4. You should get a box saying "No interferences detected"


{% endblock post_body %}

{% block footnote %}
{% endblock footnote %}

{% block post_right %}
{% endblock post_right %}
