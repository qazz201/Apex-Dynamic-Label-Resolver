public with sharing class LabelGetter {

    public static Map<String, String> getLabels(List<String> labels) {
        PageReference page = new PageReference('/apex/LabelResolver');
        page.getParameters().put('labels', JSON.serialize(labels));
        String body = page.getContent().toString();

        return extractLabelsFromVfPage(body);
    }

    private static Map<String, String> extractLabelsFromVfPage(String vfPageBody) {
        Map<String, String> labelsApiNameValue = new Map<String, String>();

        List<String> bodyLabelsApiValue = vfPageBody.substringBetween(
                LabelResolverController.LABEL_START_SEPARATOR,
                LabelResolverController.LABEL_END_SEPARATOR
        )
                .split(',');

        for (String labelApiValue : bodyLabelsApiValue) {
            List<String> extractedLabelApiToValue = labelApiValue.split(LabelResolverController.LABEL_API_TO_VALUE_SEPARATOR);

            if (isListPositionExist(extractedLabelApiToValue, 0) && isListPositionExist(extractedLabelApiToValue, 1))
                labelsApiNameValue.put(extractedLabelApiToValue[0], extractedLabelApiToValue[1]);
        }

        return labelsApiNameValue;
    }

    private static Boolean isListPositionExist(List<String> elementList, Integer position) {
        return position <= elementList.size() - 1;
    }
}