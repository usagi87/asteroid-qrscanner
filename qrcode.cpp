#include "qrcode.h"
#include <string>
#include <vector>
#include <sstream>
#include <QImage>
#include <QFile>
#include <QDebug>
#include "QZXing.h"

using namespace std;

QString QRCode::readQRCodeTest(QString filename){
	QImage imageToDecode(filename);
	QZXing decoder;
        //mandatory settings
	decoder.setDecoder( QZXing::DecoderFormat_QR_CODE | QZXing::DecoderFormat_EAN_13 );

        //optional settings
    decoder.setSourceFilterType(QZXing::SourceFilter_ImageNormal | QZXing::SourceFilter_ImageInverted);
    decoder.setSourceFilterType(QZXing::SourceFilter_ImageNormal);
    decoder.setTryHarderBehaviour(QZXing::TryHarderBehaviour_ThoroughScanning | QZXing::TryHarderBehaviour_Rotate);

        //trigger decode
	QString result = decoder.decodeImage(imageToDecode);
	if(result == "") {
		return "Error";
	}
	result = result.simplified();
	return result;
}
