public class Car extends Vehicle{
    
    private Integer steeringRotation;
    private Integer tireRotation;
    private String gear;

    public Car(String name, Integer speed, Integer occupants) {
        super(name, speed, occupants, new List<Vehicle.Medium>{Vehicle.Medium.LAND});
        this.steeringRotation = 0;
        this.tireRotation = 0;
        this.gear = 'N'; 
    }

    public void Turn(String direction, Integer amount) {
        if (direction == 'left' || direction == 'right') {
            Integer rotationAmount = direction == 'left' ? -amount : amount;
            this.steeringRotation = Math.min(Math.max(this.steeringRotation + rotationAmount, -1440), 1440);
            this.tireRotation = Math.min(Math.max(this.tireRotation + rotationAmount / 16, -90), 90);
        } else {
            System.debug('Invalid direction specified. Use "left" or "right".');
        }
    }
}