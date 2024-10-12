package com.Init.util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class DateFormatterUtil {
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    public static String formatDate(LocalDate date) {
        return date != null ? date.format(formatter) : "";
    }

    public static LocalDate parseDate(String dateString) {
        return dateString != null && !dateString.isEmpty() ? LocalDate.parse(dateString, formatter) : null;
    }
}