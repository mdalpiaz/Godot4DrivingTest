using Godot;
using System;

public partial class car_controls : Node3D
{
    private const float FRICTION = 3f;
    private const float MAX_SPEED = 0.2f;
    private const float ACCELERATION = 5f;
    private const float STEERING_SENSITIVITY = 0.5f;
    private Vector3 dir = Vector3.Forward;
    private float speed = 0.0f;
    private float rotationSpeed = Mathf.DegToRad(180);

    public override void _PhysicsProcess(double delta)
    {
        if (Input.IsActionPressed("forward"))
        {
            speed = Mathf.Lerp(speed, MAX_SPEED, ACCELERATION * (float)delta);
        } else if (Input.IsActionPressed("backward")) {
            speed = Mathf.Lerp(speed, -MAX_SPEED, ACCELERATION * (float)delta);
        }
        speed = Mathf.Lerp(speed, 0, FRICTION * (float)delta);
        var steering = Input.GetAxis("right", "left");
        Steer(steering);
        Translate(dir * speed);
    }

    private void Steer(float steering)
    {
        RotateY(steering * speed * STEERING_SENSITIVITY);
    }
}
