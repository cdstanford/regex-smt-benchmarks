;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\d{2})|(\d))\/((\d{2})|(\d))\/((\d{4})|(\d{2}))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "e2/65/82\u009E"
(define-fun Witness1 () String (seq.++ "e" (seq.++ "2" (seq.++ "/" (seq.++ "6" (seq.++ "5" (seq.++ "/" (seq.++ "8" (seq.++ "2" (seq.++ "\x9e" ""))))))))))
;witness2: "\u0084Ck]+J\u00B79/5/98"
(define-fun Witness2 () String (seq.++ "\x84" (seq.++ "C" (seq.++ "k" (seq.++ "]" (seq.++ "+" (seq.++ "J" (seq.++ "\xb7" (seq.++ "9" (seq.++ "/" (seq.++ "5" (seq.++ "/" (seq.++ "9" (seq.++ "8" ""))))))))))))))

(assert (= regexA (re.++ (re.union ((_ re.loop 2 2) (re.range "0" "9")) (re.range "0" "9"))(re.++ (re.range "/" "/")(re.++ (re.union ((_ re.loop 2 2) (re.range "0" "9")) (re.range "0" "9"))(re.++ (re.range "/" "/") (re.union ((_ re.loop 4 4) (re.range "0" "9")) ((_ re.loop 2 2) (re.range "0" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
