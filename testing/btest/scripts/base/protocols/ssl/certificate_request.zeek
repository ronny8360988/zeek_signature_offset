# This tests the certificate_request message parsing

# Does not work in spicy version, due to missing DTLS support
# @TEST-REQUIRES: ! grep -q "#define ENABLE_SPICY_SSL" $BUILD/zeek-config.h

# @TEST-EXEC: zeek -b -r $TRACES/tls/client-certificate.pcap %INPUT > out
# @TEST-EXEC: zeek -C -b -r $TRACES/tls/certificate-request-failed.pcap %INPUT >> out
# @TEST-EXEC: zeek -C -b -r $TRACES/tls/webrtc-stun.pcap %INPUT >> out
# @TEST-EXEC: zeek -C -b -r $TRACES/mysql/encrypted.trace %INPUT >> out
# @TEST-EXEC: btest-diff out

@load base/protocols/ssl
@load base/protocols/mysql

event ssl_certificate_request(c: connection, is_client: bool, certificate_types: index_vec, supported_signature_algorithms: signature_and_hashalgorithm_vec, certificate_authorities: string_vec)
	{
	print certificate_types;
	print supported_signature_algorithms;
	for ( _, ca in certificate_authorities )
		{
		print ca;
		print parse_distinguished_name(ca);
		}
	print "========";
	}
