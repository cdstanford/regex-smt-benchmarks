;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^\+[0-9]{2}|^\+[0-9]{2}\(0\)|^\(\+[0-9]{2}\)\(0\)|^00[0-9]{2}|^0)([0-9]{9}$|[0-9\-\s]{10}$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0\xD\xA\x98\xC\u00A03\x9\u00A0\xC"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "\x0d" (seq.++ "\x0a" (seq.++ "\x09" (seq.++ "8" (seq.++ "\x0c" (seq.++ "\xa0" (seq.++ "3" (seq.++ "\x09" (seq.++ "\xa0" (seq.++ "\x0c" ""))))))))))))
;witness2: "0074894960497"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "0" (seq.++ "7" (seq.++ "4" (seq.++ "8" (seq.++ "9" (seq.++ "4" (seq.++ "9" (seq.++ "6" (seq.++ "0" (seq.++ "4" (seq.++ "9" (seq.++ "7" ""))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (str.to_re "")(re.++ (re.range "+" "+") ((_ re.loop 2 2) (re.range "0" "9"))))(re.union (re.++ (str.to_re "")(re.++ (re.range "+" "+")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re (seq.++ "(" (seq.++ "0" (seq.++ ")" "")))))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "(" (seq.++ "+" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re (seq.++ ")" (seq.++ "(" (seq.++ "0" (seq.++ ")" ""))))))))(re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "0" (seq.++ "0" ""))) ((_ re.loop 2 2) (re.range "0" "9")))) (re.++ (str.to_re "") (re.range "0" "0")))))) (re.union (re.++ ((_ re.loop 9 9) (re.range "0" "9")) (str.to_re "")) (re.++ ((_ re.loop 10 10) (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
