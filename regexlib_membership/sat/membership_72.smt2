;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((([1]?\d)?\d|2[0-4]\d|25[0-5])\.){3}(([1]?\d)?\d|2[0-4]\d|25[0-5]))|([\da-fA-F]{1,4}(\:[\da-fA-F]{1,4}){7})|(([\da-fA-F]{1,4}:){0,5}::([\da-fA-F]{1,4}:){0,5}[\da-fA-F]{1,4})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "C:d99F:4A8:AA:::9cE8:28F"
(define-fun Witness1 () String (seq.++ "C" (seq.++ ":" (seq.++ "d" (seq.++ "9" (seq.++ "9" (seq.++ "F" (seq.++ ":" (seq.++ "4" (seq.++ "A" (seq.++ "8" (seq.++ ":" (seq.++ "A" (seq.++ "A" (seq.++ ":" (seq.++ ":" (seq.++ ":" (seq.++ "9" (seq.++ "c" (seq.++ "E" (seq.++ "8" (seq.++ ":" (seq.++ "2" (seq.++ "8" (seq.++ "F" "")))))))))))))))))))))))))
;witness2: " \u00A6[\u00F3\x16098:7fe7:2:A88:95A:9AB:0:8f\xA\x10\x1D\u009C\u0090"
(define-fun Witness2 () String (seq.++ " " (seq.++ "\xa6" (seq.++ "[" (seq.++ "\xf3" (seq.++ "\x16" (seq.++ "0" (seq.++ "9" (seq.++ "8" (seq.++ ":" (seq.++ "7" (seq.++ "f" (seq.++ "e" (seq.++ "7" (seq.++ ":" (seq.++ "2" (seq.++ ":" (seq.++ "A" (seq.++ "8" (seq.++ "8" (seq.++ ":" (seq.++ "9" (seq.++ "5" (seq.++ "A" (seq.++ ":" (seq.++ "9" (seq.++ "A" (seq.++ "B" (seq.++ ":" (seq.++ "0" (seq.++ ":" (seq.++ "8" (seq.++ "f" (seq.++ "\x0a" (seq.++ "\x10" (seq.++ "\x1d" (seq.++ "\x9c" (seq.++ "\x90" ""))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ ((_ re.loop 3 3) (re.++ (re.union (re.++ (re.opt (re.++ (re.opt (re.range "1" "1")) (re.range "0" "9"))) (re.range "0" "9"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5")))) (re.range "." "."))) (re.union (re.++ (re.opt (re.++ (re.opt (re.range "1" "1")) (re.range "0" "9"))) (re.range "0" "9"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))))))(re.union (re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) ((_ re.loop 7 7) (re.++ (re.range ":" ":") ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))) (re.++ (re.++ ((_ re.loop 0 5) (re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range ":" ":")))(re.++ (str.to_re (seq.++ ":" (seq.++ ":" "")))(re.++ ((_ re.loop 0 5) (re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range ":" ":"))) ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
