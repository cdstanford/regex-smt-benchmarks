;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = /(A|B|AB|O)[+-]/
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00BE/AB-/"
(define-fun Witness1 () String (seq.++ "\xbe" (seq.++ "/" (seq.++ "A" (seq.++ "B" (seq.++ "-" (seq.++ "/" "")))))))
;witness2: "/O+/"
(define-fun Witness2 () String (seq.++ "/" (seq.++ "O" (seq.++ "+" (seq.++ "/" "")))))

(assert (= regexA (re.++ (re.range "/" "/")(re.++ (re.union (re.range "A" "B")(re.union (str.to_re (seq.++ "A" (seq.++ "B" ""))) (re.range "O" "O")))(re.++ (re.union (re.range "+" "+") (re.range "-" "-")) (re.range "/" "/"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
