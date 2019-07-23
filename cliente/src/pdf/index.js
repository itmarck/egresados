import { basica } from './basica';

export function generarPDF(datos, plantilla, color) {
  switch (plantilla) {
    case 0:
      basica(datos, color);
      break;

    default:
      break;
  }
}
