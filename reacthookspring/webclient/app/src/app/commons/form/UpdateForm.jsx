import React from "react";
import Button from "@material-ui/core/Button";
import {TextField} from "@mui/material";
import {useTranslation} from "react-i18next";

function UpdateForm(props) {
    const {classes, entity, attributes, prefix, handleSubmit, handleChange} = props;
    const {t} = useTranslation();

    return (
        <form
            className={classes.container}
            autoComplete="off"
            onSubmit={handleSubmit}>

            {attributes.map(attribute =>
                <React.Fragment key={attribute.name}>
                    <TextField
                        inputProps={attribute.inputProps}
                        key={attribute.name}
                        id={"input-" + attribute.name}
                        label={t(prefix + "." + attribute.name)}
                        name={attribute.name}
                        type={attribute.type}
                        value={entity[attribute.name] !== null ? entity[attribute.name] : ""}
                        className={classes.textField}
                        onChange={handleChange}
                        margin="normal"
                    />
                    <br/>
                </React.Fragment>
            )}
            <br/>
            <Button type="submit" variant="contained" color="primary">
                {t("button.submit")}
            </Button>
        </form>
    );
}

export default UpdateForm;
