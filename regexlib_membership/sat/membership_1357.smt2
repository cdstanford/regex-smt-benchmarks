;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z0-9\x20'\.]{8,64}[^\s]$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "xMlN8F.e\u009A"
(define-fun Witness1 () String (seq.++ "x" (seq.++ "M" (seq.++ "l" (seq.++ "N" (seq.++ "8" (seq.++ "F" (seq.++ "." (seq.++ "e" (seq.++ "\x9a" ""))))))))))
;witness2: "s9..z9p9\u008A"
(define-fun Witness2 () String (seq.++ "s" (seq.++ "9" (seq.++ "." (seq.++ "." (seq.++ "z" (seq.++ "9" (seq.++ "p" (seq.++ "9" (seq.++ "\x8a" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 8 64) (re.union (re.range " " " ")(re.union (re.range "'" "'")(re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))(re.++ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
