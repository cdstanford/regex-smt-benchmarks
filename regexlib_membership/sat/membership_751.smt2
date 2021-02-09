;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[^\s]+@[^\.][^\s]{1,}\.[A-Za-z]{2,10}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x8\u00AC@\x1=.XP"
(define-fun Witness1 () String (seq.++ "\x08" (seq.++ "\xac" (seq.++ "@" (seq.++ "\x01" (seq.++ "=" (seq.++ "." (seq.++ "X" (seq.++ "P" "")))))))))
;witness2: "f@\u00B6-bO\u00F2k8\x1EK.bZ"
(define-fun Witness2 () String (seq.++ "f" (seq.++ "@" (seq.++ "\xb6" (seq.++ "-" (seq.++ "b" (seq.++ "O" (seq.++ "\xf2" (seq.++ "k" (seq.++ "8" (seq.++ "\x1e" (seq.++ "K" (seq.++ "." (seq.++ "b" (seq.++ "Z" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff"))))))(re.++ (re.range "@" "@")(re.++ (re.union (re.range "\x00" "-") (re.range "/" "\xff"))(re.++ (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff"))))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 10) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
