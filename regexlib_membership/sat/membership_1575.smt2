;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [^!~/&gt;&lt;\|/#%():;{}`_-]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\'"
(define-fun Witness1 () String (seq.++ "'" ""))
;witness2: "\u0082"
(define-fun Witness2 () String (seq.++ "\x82" ""))

(assert (= regexA (re.union (re.range "\x00" " ")(re.union (re.range "\x22" "\x22")(re.union (re.range "$" "$")(re.union (re.range "'" "'")(re.union (re.range "*" ",")(re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "<" "^")(re.union (re.range "a" "f")(re.union (re.range "h" "k")(re.union (re.range "m" "s")(re.union (re.range "u" "z") (re.range "\x7f" "\xff")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
