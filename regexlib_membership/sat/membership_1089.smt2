;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((67\d{2})|(4\d{3})|(5[1-5]\d{2})|(6011))-?\s?\d{4}-?\s?\d{4}-?\s?\d{4}|3[4,7]\d{13}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "4995-\u00A089886808-5888P\u00F1\u00F7"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "9" (seq.++ "9" (seq.++ "5" (seq.++ "-" (seq.++ "\xa0" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "6" (seq.++ "8" (seq.++ "0" (seq.++ "8" (seq.++ "-" (seq.++ "5" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "P" (seq.++ "\xf1" (seq.++ "\xf7" "")))))))))))))))))))))))
;witness2: "4964-\x93869-\u00A01944-90711"
(define-fun Witness2 () String (seq.++ "4" (seq.++ "9" (seq.++ "6" (seq.++ "4" (seq.++ "-" (seq.++ "\x09" (seq.++ "3" (seq.++ "8" (seq.++ "6" (seq.++ "9" (seq.++ "-" (seq.++ "\xa0" (seq.++ "1" (seq.++ "9" (seq.++ "4" (seq.++ "4" (seq.++ "-" (seq.++ "9" (seq.++ "0" (seq.++ "7" (seq.++ "1" (seq.++ "1" "")))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (seq.++ "6" (seq.++ "7" ""))) ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "4" "4") ((_ re.loop 3 3) (re.range "0" "9")))(re.union (re.++ (re.range "5" "5")(re.++ (re.range "1" "5") ((_ re.loop 2 2) (re.range "0" "9")))) (str.to_re (seq.++ "6" (seq.++ "0" (seq.++ "1" (seq.++ "1" ""))))))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 4 4) (re.range "0" "9")))))))))))) (re.++ (re.range "3" "3")(re.++ (re.union (re.range "," ",")(re.union (re.range "4" "4") (re.range "7" "7")))(re.++ ((_ re.loop 13 13) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
