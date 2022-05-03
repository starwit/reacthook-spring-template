import React from "react";
import {useTranslation} from "react-i18next";
import ValidatedTextField from "../inputFields/validatedTextField/ValidatedTextField";
import UpdateFormStyles from "./UpdateFormStyles";

function UpdateField(props) {
    const {entity, field, prefix, handleChange, ...newProps} = props;
    const {t} = useTranslation();
    const updateFormStyles = UpdateFormStyles();

    return (

        <ValidatedTextField
            inputProps={field.inputProps}
            key={field.name}
            id={"input-" + field.name}
            label={t(prefix + "." + field.name)}
            helperText={t(prefix + "." + field.name + ".hint")}
            name={field.name}
            type={field.type}
            value={entity[field.name] !== null ? entity[field.name] : ""}
            className={updateFormStyles.textField}
            onChange={handleChange}
            margin="normal"
            isCreate={!entity?.id}
            regex={field.regex}
            {...newProps}
        />
    );
}

export default UpdateField;
