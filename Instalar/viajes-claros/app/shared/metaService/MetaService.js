
/**
 * Se utiliza para poder sobre-escribir los metadatos (para compartir en facebook)
 * @param {type} param1
 * @param {type} param2
 */
myApp.service('MetaService', function () {
    
    var title = '';
    var url = '';
    var description = '';
    
    return {
        set: function (newTitle, newMetaDescription, newUrl) {
            url = newUrl;
            description = newMetaDescription;
            title = newTitle;
        },
        getTitle: function () {
            return title;
        },
        getDescription: function () {
            return description;
        },
        getUrl: function () {
            return url;
        }
    };
});
