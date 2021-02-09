;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[http://www.|www.][\S]+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ":R"
(define-fun Witness1 () String (seq.++ ":" (seq.++ "R" "")))
;witness2: ":\u00CA\u00C4"
(define-fun Witness2 () String (seq.++ ":" (seq.++ "\xca" (seq.++ "\xc4" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "." "/")(re.union (re.range ":" ":")(re.union (re.range "h" "h")(re.union (re.range "p" "p")(re.union (re.range "t" "t")(re.union (re.range "w" "w") (re.range "|" "|")))))))(re.++ (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
