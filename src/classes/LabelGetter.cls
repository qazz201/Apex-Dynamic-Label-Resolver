public with sharing class LabelGetter {

    public static Map<String, String> getLabels(List<String> labels) {

        PageReference visualf_page = new PageReference('/apex/LabelResolver');
        visualf_page.getParameters().put('labels', JSON.serialize(labels));
        Blob visualforce_body = visualf_page.getContent();
        String toCut = visualforce_body.toString();
        //String label = toCut.substringBetween('---STARTLABEL', '---ENDLABEL');
        //return label;
        System.debug(toCut);
        return null;
    }
}