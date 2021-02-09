;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-9]{4}\s{0,2}[a-zA-z]{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "1198\u0085Rb"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "1" (seq.++ "9" (seq.++ "8" (seq.++ "\x85" (seq.++ "R" (seq.++ "b" ""))))))))
;witness2: "9896\u0085da"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "6" (seq.++ "\x85" (seq.++ "d" (seq.++ "a" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ ((_ re.loop 0 2) (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 2 2) (re.range "A" "z")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
