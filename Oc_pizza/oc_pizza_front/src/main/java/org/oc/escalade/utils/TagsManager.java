package org.oc.escalade.utils;

import org.oc.escalade.models.Tag;

import java.util.List;
import java.util.Map;

public final  class TagsManager {
    public static Map<String, Boolean> getAllTags() {
        return  Tag.getAllTags();
    }
}
