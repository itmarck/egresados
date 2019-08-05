import { plantilla1 } from './plantilla1';
import { plantilla2 } from './plantilla2';

export function generarPDF(datos, plantilla, color) {
  switch (plantilla) {
    case 0:
      plantilla1(datos, color);
      break;
    case 1:
      plantilla2(datos, color);
      break;
  }
}
