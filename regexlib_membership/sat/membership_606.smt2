;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \[(?<GroupName>.*)\](?<GroupContent>[^\[]+)       --------        [\s]*(?<Key>.+)[\s]*=[\s]*(?<Value>[^\r]+) 
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "[]a       --------        \u00B0\x9=\u00DF \u0092\u00F4"
(define-fun Witness1 () String (seq.++ "[" (seq.++ "]" (seq.++ "a" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "\xb0" (seq.++ "\x09" (seq.++ "=" (seq.++ "\xdf" (seq.++ " " (seq.++ "\x92" (seq.++ "\xf4" ""))))))))))))))))))))))))))))))))))
;witness2: "[]%U       --------        \u0085\xD\x9\xD\u00F8Y\u008F=\u0085 \u00A3 7\u00CE"
(define-fun Witness2 () String (seq.++ "[" (seq.++ "]" (seq.++ "%" (seq.++ "U" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "\x85" (seq.++ "\x0d" (seq.++ "\x09" (seq.++ "\x0d" (seq.++ "\xf8" (seq.++ "Y" (seq.++ "\x8f" (seq.++ "=" (seq.++ "\x85" (seq.++ " " (seq.++ "\xa3" (seq.++ " " (seq.++ "7" (seq.++ "\xce" ""))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.range "[" "[")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "]" "]")(re.++ (re.+ (re.union (re.range "\x00" "Z") (re.range "\x5c" "\xff")))(re.++ (str.to_re (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " (seq.++ " " ""))))))))))))))))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "\x00" "\x0c") (re.range "\x0e" "\xff"))) (re.range " " " "))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
