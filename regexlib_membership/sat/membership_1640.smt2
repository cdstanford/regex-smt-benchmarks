;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[1-9][0-9]{3}\s?[a-zA-Z]{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "6888\u0085kZ"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "\x85" (seq.++ "k" (seq.++ "Z" ""))))))))
;witness2: "3895pP"
(define-fun Witness2 () String (seq.++ "3" (seq.++ "8" (seq.++ "9" (seq.++ "5" (seq.++ "p" (seq.++ "P" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "1" "9")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
