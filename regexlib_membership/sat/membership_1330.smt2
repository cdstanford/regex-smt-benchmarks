;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d?\d'(\d|1[01])?.?(\d|1[01])&quot;$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "5\'11&quot;"
(define-fun Witness1 () String (seq.++ "5" (seq.++ "'" (seq.++ "1" (seq.++ "1" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" "")))))))))))
;witness2: "64\'9\u00AF11&quot;"
(define-fun Witness2 () String (seq.++ "6" (seq.++ "4" (seq.++ "'" (seq.++ "9" (seq.++ "\xaf" (seq.++ "1" (seq.++ "1" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "0" "9"))(re.++ (re.range "0" "9")(re.++ (re.range "'" "'")(re.++ (re.opt (re.union (re.range "0" "9") (re.++ (re.range "1" "1") (re.range "0" "1"))))(re.++ (re.opt (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.union (re.range "0" "9") (re.++ (re.range "1" "1") (re.range "0" "1")))(re.++ (str.to_re (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" ""))))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
