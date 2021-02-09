;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^0[1-6]{1}(([0-9]{2}){4})|((\s[0-9]{2}){4})|((-[0-9]{2}){4})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "-99-89-97-88"
(define-fun Witness1 () String (seq.++ "-" (seq.++ "9" (seq.++ "9" (seq.++ "-" (seq.++ "8" (seq.++ "9" (seq.++ "-" (seq.++ "9" (seq.++ "7" (seq.++ "-" (seq.++ "8" (seq.++ "8" "")))))))))))))
;witness2: "\x11\u009A\u00B4-49-58-63-98"
(define-fun Witness2 () String (seq.++ "\x11" (seq.++ "\x9a" (seq.++ "\xb4" (seq.++ "-" (seq.++ "4" (seq.++ "9" (seq.++ "-" (seq.++ "5" (seq.++ "8" (seq.++ "-" (seq.++ "6" (seq.++ "3" (seq.++ "-" (seq.++ "9" (seq.++ "8" ""))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "0" "0")(re.++ (re.range "1" "6") ((_ re.loop 4 4) ((_ re.loop 2 2) (re.range "0" "9"))))))(re.union ((_ re.loop 4 4) (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) ((_ re.loop 2 2) (re.range "0" "9")))) (re.++ ((_ re.loop 4 4) (re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
