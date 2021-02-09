;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([.])([a-z,1-9]{3,4})(\/)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ".,82/"
(define-fun Witness1 () String (seq.++ "." (seq.++ "," (seq.++ "8" (seq.++ "2" (seq.++ "/" ""))))))
;witness2: "\u00BE.rs,/\u00E8\x1F"
(define-fun Witness2 () String (seq.++ "\xbe" (seq.++ "." (seq.++ "r" (seq.++ "s" (seq.++ "," (seq.++ "/" (seq.++ "\xe8" (seq.++ "\x1f" "")))))))))

(assert (= regexA (re.++ (re.range "." ".")(re.++ ((_ re.loop 3 4) (re.union (re.range "," ",")(re.union (re.range "1" "9") (re.range "a" "z")))) (re.range "/" "/")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
