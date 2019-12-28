package com.qyhl.tpsb.commonutils;

import java.io.IOException;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;


  public class JsonLongSerializer extends JsonSerializer<Long> {
	    @Override
	    public void serialize(Long aLong, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
	        jsonGenerator.writeString(Long.toString(aLong));
	    }
	}


