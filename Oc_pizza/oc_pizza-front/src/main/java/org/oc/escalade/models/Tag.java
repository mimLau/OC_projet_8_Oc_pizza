package org.oc.escalade.models;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public enum Tag {

    OFFICIAL_SITE("Site officiel", true ),
    NON_OFFICIAL_SITE("Site non officiel", false);


    private String mess;
    private Boolean value;

    Tag(String mess, boolean value) {
        this.mess = mess;
        this.value = value;
    }

    public String getMess() {
        return mess;
    }

    public Boolean getValue() {
        return value;
    }

    public static Map<String, Boolean> getAllTags() {
        Map<String, Boolean> tags = new HashMap<>();
        for(Tag tag : Tag.values()) {
            tags.put(tag.getMess(), tag.getValue());
        }
        return tags;
    }

}
