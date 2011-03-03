﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Xml;
using System.Xml.Linq;

namespace LinqToSqlXml
{
    public static class DocumentDeserializer
    {
        public static object Deserialize(XElement xml)
        {
            //todo fix

// ReSharper disable PossibleNullReferenceException
            string typeName = xml.Attribute("type").Value;
// ReSharper restore PossibleNullReferenceException
            string value = xml.Value;
            if (typeName == "string")
                return DeserializeString(value);
            if (typeName == "guid")
                return DeserializeGuid(value);
            if (typeName == "bool")
                return DeserializeBool(value);
            if (typeName == "int")
                return DeserializeInt(value);
            if (typeName == "double")
                return DeserializeDouble(value);
            if (typeName == "decimal")
                return DeserializeDecimal(value);
            if (typeName == "datetime")
                return DeserializeDateTime(value);
            if (typeName == "null")
                return null;
            if (typeName == "collection")
                return xml.Elements().Select(Deserialize).ToList();


            Type type = Type.GetType(typeName);

            if (type == null)
                return null;

            object result = Activator.CreateInstance(type, null);
            foreach (XElement xProperty in xml.Elements().Where(e => !e.Name.LocalName.StartsWith("__")))
            {
                PropertyInfo property = type.GetProperty(xProperty.Name.LocalName);
                if (property.CanWrite == false)
                    continue;

                object propertyValue = Deserialize(xProperty);
                if (propertyValue is List<object>)
                {
                    DeserializeList(value, property, propertyValue, result);
                }
                else
                {
                    property.SetValue(result, propertyValue, null);
                }
            }
            return result;
        }

        private static void DeserializeList(string value, PropertyInfo property, object propertyValue, object result)
        {
            var list = (List<object>) propertyValue;
            Type collectionType = property.PropertyType;
            if (collectionType.IsInterface && collectionType.IsGenericType)
            {
                Type elementType = collectionType.GetGenericArguments().First();
                Type concreteType = typeof (List<>).MakeGenericType(elementType);
                var concreteList = (IList) Activator.CreateInstance(concreteType);
                foreach (object item in list)
                    concreteList.Add(item);
                property.SetValue(result, concreteList, null);
            }
            else if (typeof (Array).IsAssignableFrom(collectionType))
            {
                int length = list.Count;
                Array arr = null;
                for (int i = 0; i < length; i++)
                {
                    arr.SetValue(list[i], i);
                }
                property.SetValue(result, arr, null);
            }
            else if (collectionType == typeof (object))
            {
                property.SetValue(result, value, null);
            }
        }

        private static object DeserializeDateTime(string propertyString)
        {
            return XmlConvert.ToDateTime(propertyString, XmlDateTimeSerializationMode.Local);
        }

        private static object DeserializeDecimal(string propertyString)
        {
            return XmlConvert.ToDecimal(propertyString);
        }

        private static object DeserializeDouble(string propertyString)
        {
            return XmlConvert.ToDouble(propertyString);
        }

        private static object DeserializeInt(string propertyString)
        {
            return XmlConvert.ToInt32(propertyString);
        }

        private static object DeserializeBool(string propertyString)
        {
            return XmlConvert.ToBoolean(propertyString);
        }

        private static object DeserializeGuid(string propertyString)
        {
            return XmlConvert.ToGuid(propertyString);
        }

        private static object DeserializeString(string propertyString)
        {
            return propertyString;
        }
    }
}