public with sharing class Calculator {
    public Calculator() {

    }

    public Integer addVal(Integer a, Integer b){
        return a + b;
    }
    public Integer multiplyVal(Integer a, Integer b){
        Integer val = 0;
        for(Integer i = 0; i < b; i++){
            val += a;
        }
        return val;
    }
    public Double divideVal(Integer a, Integer b){
        if( b == 0){
            return 0;
        }

        Double quotient = 0;

        while(a >= b){
            a -= b;
            quotient++;
        }
        
        return quotient;
    }
    public Integer modulus(Integer a, Integer b){
        if( b == 0){
            return 0;
        }

        Integer quotient = 0;
        while(a >= b){
            a -= b;
        }

        return a;
    }

    
}