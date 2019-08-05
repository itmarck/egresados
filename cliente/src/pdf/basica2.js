import * as jsPDF from 'jspdf';
import { urlImage } from '../bd/config';

const margen = 10;
const MARGEN = 15;
const MAXWIDTH = 210;
const MAXHEIGHT = 297;
var COLOR = {
  principal: '#424242',
  negro: '#000000',
  blanco: '#FFFFFF',
  texto: '#5B5B5B',
  textoClaro: '#8E8E8E',
  gris: '#EBEBEB'
};
const SIZES = {
  sidebar: 70
};

var doc = new jsPDF();

function fotoPerfil(foto) {
  let img = new Image();
  img.src = urlImage + foto;

  doc.addImage(
    img,
    'JPEG',
    MARGEN,
    MARGEN,
    SIZES.sidebar - MARGEN * 2,
    SIZES.sidebar - MARGEN * 2
  );
}

function subtituloSidebar(texto, y) {
  doc
    .setFontSize(14)
    .setTextColor(COLOR.principal)
    .setFontStyle('bold')
    .text(texto.toUpperCase(), MARGEN, y);
}

function datosSidebar(datos = [], y) {
  y += 8;
  for (let i = 0; i < datos.length; i++) {
    doc
      .setFontSize(10)
      .setTextColor(COLOR.texto)
      .setFontStyle('normal');
    let options = { maxWidth: SIZES.sidebar - MARGEN * 2 };
    if (i == 0) options = {};
    doc.text(datos[i], MARGEN, y, options);
    y += 6;
  }
}

function tituloPrincipal(texto) {
  doc
    .setFontSize(24)
    .setTextColor(COLOR.principal)
    .setFontStyle('bold')
    .text(texto.toUpperCase(), SIZES.sidebar + margen, MARGEN + 5, {
      baseline: 'top'
    });
}

function subtituloPrincipal(texto) {
  doc
    .setFontSize(12)
    .setTextColor(COLOR.principal)
    .setFontStyle('normal')
    .text(texto.toUpperCase(), SIZES.sidebar + margen, MARGEN + 16, {
      baseline: 'top'
    });
}

function subtituloSecundario(texto, y) {
  doc.setFillColor(COLOR.gris);
  doc.rect(
    SIZES.sidebar + margen,
    y,
    MAXWIDTH - SIZES.sidebar - margen - MARGEN,
    8,
    'F'
  );
  doc
    .setFontSize(12)
    .setTextColor(COLOR.principal)
    .setFontStyle('bold')
    .text(texto, SIZES.sidebar + margen + 10, y + 4, {
      baseline: 'middle'
    });
  y += 20;
  return y;
}

function datosExperiencia(datos, y) {
  y = validarPagina(y);
  for (let i = 0; i < datos.length; i++) {
    doc
      .setFontSize(12)
      .setTextColor(COLOR.texto)
      .setFontStyle('bold')
      .text(datos[i].fecha, SIZES.sidebar + margen + 10, y);
    doc.text(datos[i].centro, SIZES.sidebar + margen + 40, y);
    doc.setFontSize(10).setFontStyle('italic');
    doc
      .setTextColor(COLOR.textoClaro)
      .text(datos[i].cargo, SIZES.sidebar + margen + 40, y + 6);
    doc
      .setFontStyle('normal')
      .setFontSize(8)
      .text(datos[i].tiempo, SIZES.sidebar + margen + 10, y + 4);
    doc.setFontSize(10).setTextColor(COLOR.texto);

    let descripcion = doc.splitTextToSize(
      datos[i].descripcion,
      MAXWIDTH - SIZES.sidebar - margen - 40 - MARGEN
    );
    y += 12;
    descripcion.forEach((e, index) => {
      y = validarPagina(y);
      if (index > 0 && index < descripcion.length) y += 5;
      doc.text(e, SIZES.sidebar + margen + 40, y);
    });
    y += 8;
  }
  return y;
}

function datosEducacion(datos, y) {
  for (let i = 0; i < datos.length; i++) {
    y = validarPagina(y);
    doc
      .setFontSize(12)
      .setTextColor(COLOR.texto)
      .setFontStyle('bold')
      .text(datos[i].fecha, SIZES.sidebar + margen + 10, y);
    let nombre = doc.splitTextToSize(
      datos[i].nombre,
      MAXWIDTH - SIZES.sidebar - margen - 40 - MARGEN
    );
    nombre.forEach((e, index) => {
      if (index > 0 && index < nombre.length) y += 6;
      doc.text(e, SIZES.sidebar + margen + 40, y);
    });

    doc.setFontSize(10).setFontStyle('italic');
    doc
      .setTextColor(COLOR.textoClaro)
      .text(datos[i].tipo, SIZES.sidebar + margen + 40, y + 6);
    doc
      .setFontStyle('normal')
      .setFontSize(8)
      .text(datos[i].anio, SIZES.sidebar + margen + 10, y + 4);
    doc
      .setFontSize(10)
      .setTextColor(COLOR.texto)
      .text(datos[i].lugar, SIZES.sidebar + margen + 40, y + 12, {
        maxWidth: MAXWIDTH - SIZES.sidebar - margen - 40 - MARGEN
      });
    y += 20;
  }
  return y;
}

function validarPagina(y) {
  if (y > MAXHEIGHT - MARGEN - 20) {
    doc.addPage();
    return MARGEN;
  } else return y;
}

export function basica2(datos, color) {
  init(color);

  // fotoPerfil(datos.foto);
  subtituloSidebar('CONTACTO', SIZES.sidebar);
  datosSidebar(datos.contacto, SIZES.sidebar);
  subtituloSidebar('DATOS', SIZES.sidebar + 40);
  datosSidebar(datos.personales, SIZES.sidebar + 40);

  // Main
  tituloPrincipal(datos.nombre);
  subtituloPrincipal(datos.titulo);

  let y = 50;
  if (datos.experiencia) {
    y = subtituloSecundario('EXPERIENCIA LABORAL', y);
    y = datosExperiencia(datos.experiencia, y);
  }
  if (datos.educacion) {
    y = subtituloSecundario('EDUCACIÓN', y);
    y = datosEducacion(datos.educacion, y);
  }

  save();
}

function init(color) {
  doc = new jsPDF();
  doc.setFont('helvetica', 'normal');
  COLOR.principal = color;
}

function save() {
  doc.save('curriculum.pdf');
}
