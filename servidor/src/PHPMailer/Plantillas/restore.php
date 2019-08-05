<?php
$recuperar = '<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Correo</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>

<body style="margin: 0; padding: 0;">
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td style="padding: 10px 0 30px 0;">
				<table align="center" border="0" cellpadding="0" cellspacing="0" width="650"
					style="border: 1px solid #cccccc; border-collapse: collapse;">
					<tr>
						<td align="center" bgcolor="#0D47A1"
							style="padding: 40px 0px; color: rgb(255, 255, 255); font-size: 15px; font-weight: bold;">
							<h1>EGRESADOS UNPRG</h1>
						</td>
					</tr>
					<tr>
						<td bgcolor="#ffffff" style="padding: 40px 30px 40px 30px;">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td
										style="color: #153643; font-family:Georgia, Times New Roman, Times, serif ; font-size: 24px; ">
										Hola ' . $nombre . '
									</td>
								</tr>
								<tr>
									<td
										style="color: #153643; font-family:Georgia, Times New Roman, Times, serif ; font-size: 20px; padding: 25px 0px 25px 0px">
										Hemos recibido una solicitud de cambio de clave, para poder realizar el
										cambio haz click en el siguien enlace:
									</td>
								</tr>
								<tr>
									<td>
										<table border="0" cellpadding="3px" cellspacing="0" width="100%">

											<tr>
												<td width="260" valign="top">
													<table border="0" cellpadding="0" cellspacing="0" width="100%"
														style="box-shadow: 2px 2px 20px">

														<tr>
															<td bgcolor="#0D47A1" height="65px"
																style="color: rgb(255, 255, 255);  text-align: center;   font-size: 16px; line-height: 20px;">
																<a style="text-decoration: none; border-radius: 40px ; padding: 20px ; color: #ffffff;"
																	href="' . $url . '">
																	Recuperar clave
																</a>
															</td>
														</tr>
													</table>
												</td>


											</tr>
											<tr>
												<td width="260" valign="top">
													<table border="0" cellpadding="0" cellspacing="0" width="100%">
														<td
															style="color: #153643; font-family:Georgia, Times New Roman, Times, serif ; font-size: 20px; padding: 25px 0px 25px 0px">
															Sino haz sido tu ignora este mensaje.
														</td>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td bgcolor="#0D47A1" style="padding: 30px 30px 30px 30px;">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td style="color: #ffffff; font-family: Arial, sans-serif; font-size: 14px;"
										width="75%">
										&reg; Titan, Lambayeque 2019<br />
									</td>
									<td align="right" width="25%">
										<table border="0" cellpadding="0" cellspacing="0">
											<tr>
												<td style=" font-size: 12px; font-weight: bold;">
													<a href="http://unprg.xyz"
														style="box-shadow: 2px 2px 10px 2px #000000 ; padding:15px ; color: #ffffff; text-decoration: none;">
														Visitanos
													</a>
												</td>

											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>

</html>';
