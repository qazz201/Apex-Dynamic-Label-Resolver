public with sharing class LabelResolverController {
    public List<String> labelsList { get; set; }

    public LabelResolverController() {
        String labelString = ApexPages.currentPage().getParameters().get('labels');

        if (labelString != null && labelString != '')
            labelsList = (List<String>) JSON.deserialize(labelString, List<String>.class);
    }

    public Component.Apex.Detail getLabelsValue() {
        Component.Apex.Detail detail = new Component.Apex.Detail();

        for (String label : labelsList) {
            Component.Apex.OutputText outputText = new Component.Apex.OutputText();
            outputText.expressions.value = label+'='+'{!$Label.' + label + '},';
            detail.childComponents.add(outputText);
        }

        return detail;
    }
}