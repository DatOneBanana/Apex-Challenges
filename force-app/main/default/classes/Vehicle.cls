public with sharing class Vehicle {
    public enum Medium {
        LAND,
        AIR,
        WATER
    }

    private Integer speed;
    private String name;
    private Integer occupants;
    private static final Integer CAPACITY = 1;
    protected List<Medium> media = new List<Medium>();

    public Vehicle() {
        this.name = 'Default Vehicle';
        this.speed = 0;
        this.occupants = 1;
        this.media.add(Medium.LAND);
    }

    public Vehicle(String name, Integer speed, Integer occupants, List<Medium> media) {
        this.name = name;
        this.speed = Math.max(speed, 0);
        this.occupants = Math.max(occupants, 0);
        this.media.addAll(media);
    }

    public void Accelerate(Integer amount) {
        this.speed = Math.max(this.speed + amount, 0);
    }

    public abstract void Turn(String direction);

    public String ToString() {
        return 'Name: ' + name + 
               ', Speed: ' + speed + 
               ', Occupants: ' + occupants + 
               ', Media: ' + String.join(media, ', ');
    }
    
}