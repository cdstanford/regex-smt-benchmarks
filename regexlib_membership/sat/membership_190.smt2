;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\d]{4}[-\s]{1}[\d]{3}[-\s]{1}[\d]{4}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "9998\xD887\x99394"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "\x0d" (seq.++ "8" (seq.++ "8" (seq.++ "7" (seq.++ "\x09" (seq.++ "9" (seq.++ "3" (seq.++ "9" (seq.++ "4" ""))))))))))))))
;witness2: "8984\xA890\xD8969"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "4" (seq.++ "\x0a" (seq.++ "8" (seq.++ "9" (seq.++ "0" (seq.++ "\x0d" (seq.++ "8" (seq.++ "9" (seq.++ "6" (seq.++ "9" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
