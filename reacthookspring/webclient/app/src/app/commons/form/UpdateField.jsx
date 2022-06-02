import React from "react";
import {useTranslation} from "react-i18next";
import ValidatedTextField from "../inputFields/validatedTextField/ValidatedTextField";
import UpdateFormStyles from "./UpdateFormStyles";
import {
    Checkbox
} from "@mui/material";

function UpdateField(props) {
    const {entity, field, prefix, handleChange, ...newProps} = props;
    const {t} = useTranslation();
    const updateFormStyles = UpdateFormStyles();

    if (field.type == "boolean") {
        return (
            <Checkbox
                checked={entity[field.name] !== null ? entity[field.name] : ""}
                value={entity[field.name] !== null ? entity[field.name] : ""}
                name={field.name} onChange={handleChange} key={field.name}
                id={"checkbox-" + field.name}
                label={t(prefix + "." + field.name)}
            />
        );
    }

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
            notNull={field.notNull}
            min={field.min}
            max={field.max}
            {...newProps}
        />
    );
}

export default UpdateField;
