;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\d]{5}[-\s]{1}[\d]{4}[-\s]{1}[\d]{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "78800\u00A09882\xA69"
(define-fun Witness1 () String (seq.++ "7" (seq.++ "8" (seq.++ "8" (seq.++ "0" (seq.++ "0" (seq.++ "\xa0" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "2" (seq.++ "\x0a" (seq.++ "6" (seq.++ "9" ""))))))))))))))
;witness2: "89984 9399\u00A018"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "4" (seq.++ " " (seq.++ "9" (seq.++ "3" (seq.++ "9" (seq.++ "9" (seq.++ "\xa0" (seq.++ "1" (seq.++ "8" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
