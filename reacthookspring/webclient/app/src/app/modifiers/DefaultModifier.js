function handleChange(event, setData) {
    const target = event.target;
    const value = target.type === "checkbox" ? target.checked : target.value;
    const name = target.name;
    setData(draft => {draft[name] = value;});
};

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

export {handleChange, isValid};
