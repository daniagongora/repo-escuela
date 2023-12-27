import java.util.Stack;

public class Ejercicio5{

    public static void separarPilas(Stack<Character> stack1, Stack<Character> stack2) {
    
        for (int i = 0; i < stack1.size(); i++) {
            
            for (int j = 0; j < stack2.size(); j++) {
                
                char elem1 = stack1.get(i);
                char elem2 = stack2.get(j);

                if(elem1 == 'B' && elem2 == 'A'){
                    stack1.set(i, elem2);
                    stack2.set(j, elem1);
                }

            }
        }

    }

    public static void main(String[] args) {

        Stack<Character> pilaA = new Stack<>();
        Stack<Character> pilaB = new Stack<>();

        pilaA.push('A');
        pilaA.push('B');
        pilaA.push('B');
        pilaA.push('B');
        pilaA.push('A');
        pilaA.push('B');
        pilaA.push('A');
        pilaA.push('B');
        pilaA.push('A');


        pilaB.push('A');
        pilaB.push('A');
        pilaB.push('A');
        pilaB.push('B');
        pilaB.push('B');
        pilaB.push('A');
        pilaB.push('A');
        pilaB.push('B');
        pilaB.push('B');

        System.out.println("Antes de separar:");
        System.out.println("Pila A: " + pilaA);
        System.out.println("Pila B: " + pilaB);

        separarPilas(pilaA, pilaB);

        System.out.println("Después de separar:");
        System.out.println("Pila A: " + pilaA);
        System.out.println("Pila B: " + pilaB);

    }

}


