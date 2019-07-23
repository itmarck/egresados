import { blancoNegro } from './blanco-negro';

export function generarPDF(datos, plantilla) {
  switch (plantilla) {
    case 0:
      blancoNegro(datos);
      break;

    default:
      break;
  }
}
