using Godot;
using System;

public partial class camera_lookat_pivot : Node3D
{
    private float _previousRotation;

    public override void _PhysicsProcess(double delta)
    {
        var parent = GetParent<car_controls>();
        var rotDiff = _previousRotation - parent.Rotation.Y;
        var newRotation = Rotation;
        newRotation.Z = -parent.Rotation.Z;
        newRotation.X = -parent.Rotation.X;
        newRotation.Y += rotDiff;
        newRotation.Y = Mathf.LerpAngle(newRotation.Y, 0, 10 * (float)delta);
        Rotation = newRotation;

        _previousRotation = parent.Rotation.Y;
    }
}
