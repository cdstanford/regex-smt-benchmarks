;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (0|(\+)?([1-9]{1}[0-9]{0,1}|[1]{1}[0-9]{0,2}|[2]{1}([0-4]{1}[0-9]{1}|[5]{1}[0-5]{1})))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00ED\x15*\u00918"
(define-fun Witness1 () String (seq.++ "\xed" (seq.++ "\x15" (seq.++ "*" (seq.++ "\x91" (seq.++ "8" ""))))))
;witness2: "\u00CB+82\x1CE"
(define-fun Witness2 () String (seq.++ "\xcb" (seq.++ "+" (seq.++ "8" (seq.++ "2" (seq.++ "\x1c" (seq.++ "E" "")))))))

(assert (= regexA (re.union (re.range "0" "0") (re.++ (re.opt (re.range "+" "+")) (re.union (re.++ (re.range "1" "9") (re.opt (re.range "0" "9")))(re.union (re.++ (re.range "1" "1") ((_ re.loop 0 2) (re.range "0" "9"))) (re.++ (re.range "2" "2") (re.union (re.++ (re.range "0" "4") (re.range "0" "9")) (re.++ (re.range "5" "5") (re.range "0" "5"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
