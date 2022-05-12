import {produce} from "immer";

function handleChange(event, setData) {
    const target = event.target;
    const value = target.type === "checkbox" ? target.checked : target.value;
    const name = target.name;
    setData(draft => {draft[name] = value;});
}

function handleSelect(event, setData) {
    const target = event.target;
    const name = target.name;
    const value = target.value;
    setData(draft => {draft[name] = {id: value};});
}

function handleMultiSelect(event, fields, setFields) {
    const value = event.target.value;
    const toSave = produce(fields, draft => {
        draft?.map(field => {
            field.selectedIds = value;
        });
    });
    setFields(toSave);
}

function isValid(fields, data) {
    if (!fields) {
        return true;
    }
    for (const element of fields) {
        if (!!element.regex && !element.regex.test(data[element.name])) {
            return false;
        }
    }
    return true;
}

function isSelect(fieldType) {
    return fieldType === "OneToOne" || fieldType == "ManyToOne";
}

function isMultiSelect(fieldType) {
    return fieldType === "ManyToMany" || fieldType === "OneToMany";
}

function isInput(fieldType) {
    return fieldType === "string" ||
        fieldType == "integer" ||
        fieldType == "bigdecimal" ||
        fieldType == "float" ||
        fieldType == "double" ||
        fieldType == "boolean" ||
        fieldType == "long";
}

function addSelectLists(entity, fields, setFields, selects) {
    const toSave = produce(fields, draft => {
        draft?.map(field => {
            if (isSelect(field.type) || isMultiSelect(field.type)) {
                field.selectList = selects.find(list => list.name === field.name).data;
            }
            if (isMultiSelect(field.type) && entity[field.name]) {
                field.selectedIds = [];
                entity[field.name].map(item => {
                    field.selectedIds.push(item.id);
                });
            }
        });
    });
    setFields(toSave);
}

function prepareForSave(entity, fields) {
    return produce(entity, draft => {
        fields?.map(field => {
            if (isSelect(field.type)) {
                if (draft[field.name]?.id == -1) {
                    draft[field.name] = null;
                }
            } else if (isMultiSelect(field.type)) {
                const selectedEntity = [];
                field.selectedIds.map(selectedId => {
                    selectedEntity.push({id: selectedId});
                });
                draft[field.name] = selectedEntity;
            }
        });
    });
}

export {handleChange, handleSelect, handleMultiSelect, prepareForSave, isValid, addSelectLists,
    isInput,
    isSelect,
    isMultiSelect};
