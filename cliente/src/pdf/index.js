import { basica } from './basica';
import { basica2 } from './basica2';

export function generarPDF(datos, plantilla, color) {
  switch (plantilla) {
    case 0:
      basica(datos, color);
      break;
    case 1:
      basica2(datos, color);
      break;
  }
}
