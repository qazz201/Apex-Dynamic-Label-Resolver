public with sharing class LabelResolverController {
    public static final String LABEL_START_SEPARATOR {
        get {
            return 'STARTLABEL';
        }
        set;
    }
    public static final String LABEL_END_SEPARATOR {
        get {
            return 'ENDLABEL';
        }
        set;
    }
    public static final String LABEL_API_TO_VALUE_SEPARATOR = '!#!';
    public List<String> labelsList { get; set; }

    public LabelResolverController() {
        String labelString = ApexPages.currentPage().getParameters().get('labels');

        if (labelString != null && labelString != '')
            labelsList = (List<String>) JSON.deserialize(labelString, List<String>.class);
    }

    public Component.Apex.Detail getLabelsValue() {
        Component.Apex.Detail detail = new Component.Apex.Detail();
        this.addOutputTextToDetails(detail, '{!LABEL_START_SEPARATOR}');

        for (String labelApi : labelsList) {
            if (String.isNotEmpty(labelApi))
                this.addOutputTextToDetails(detail, labelApi + LABEL_API_TO_VALUE_SEPARATOR + '{!$Label.' + labelApi + '},');
        }

        this.addOutputTextToDetails(detail, '{!LABEL_END_SEPARATOR}');

        return detail;
    }

    private void addOutputTextToDetails(Component.Apex.Detail detail, String text) {
        Component.Apex.OutputText outputTextLabelSeparator = new Component.Apex.OutputText();
        outputTextLabelSeparator.expressions.value = text;
        detail.childComponents.add(outputTextLabelSeparator);
    }
}